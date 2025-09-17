const axios = require('axios');
const { Octokit } = require('@octokit/rest');
const fs = require('fs').promises;
const path = require('path');

class ClaudeAssistant {
  constructor(anthropicApiKey, githubToken) {
    this.anthropicApiKey = anthropicApiKey;
    this.githubToken = githubToken;
    this.octokit = new Octokit({ auth: githubToken });
  }

  /**
   * Claude APIを呼び出してレスポンスを取得
   */
  async callClaude(prompt, systemPrompt = null) {
    try {
      const messages = [{
        role: 'user',
        content: prompt
      }];

      const requestBody = {
        model: 'claude-3-5-sonnet-20241022',
        max_tokens: 4096,
        messages: messages
      };

      if (systemPrompt) {
        requestBody.system = systemPrompt;
      }

      const response = await axios.post(
        'https://api.anthropic.com/v1/messages',
        requestBody,
        {
          headers: {
            'x-api-key': this.anthropicApiKey,
            'anthropic-version': '2023-06-01',
            'content-type': 'application/json'
          }
        }
      );

      return response.data.content[0].text;
    } catch (error) {
      console.error('Claude API Error:', error.response?.data || error.message);
      throw new Error(`Failed to get response from Claude: ${error.message}`);
    }
  }

  /**
   * Issueやコメントの内容を分析して実装が必要かどうか判断
   */
  async analyzeRequest(issueTitle, issueBody) {
    const systemPrompt = `You are an AI assistant that helps with software development tasks.
    Analyze the request and determine if it requires:
    1. Just answering a question
    2. Creating or modifying code
    3. Creating documentation
    4. Running tests or debugging

    Respond with a JSON object containing:
    {
      "action_type": "answer" | "implement" | "document" | "test",
      "complexity": "low" | "medium" | "high",
      "files_to_modify": [],
      "summary": "Brief summary of what needs to be done"
    }`;

    const prompt = `
    Issue Title: ${issueTitle}
    Issue Body: ${issueBody}

    Please analyze this request and determine what action is needed.
    `;

    const response = await this.callClaude(prompt, systemPrompt);

    try {
      // JSONレスポンスを抽出
      const jsonMatch = response.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
    } catch (e) {
      console.error('Failed to parse JSON response:', e);
    }

    // デフォルトレスポンス
    return {
      action_type: 'answer',
      complexity: 'low',
      files_to_modify: [],
      summary: 'General assistance required'
    };
  }

  /**
   * コードの実装を生成
   */
  async generateImplementation(issueTitle, issueBody, context = {}) {
    const systemPrompt = `You are an expert software developer working on a Flutter/Firebase project.
    The project uses:
    - Flutter for web frontend
    - Firebase Cloud Functions for backend
    - Firestore for database
    - Stripe for payments
    - Riverpod for state management

    When generating code:
    1. Follow the existing code style and patterns
    2. Use proper error handling
    3. Include necessary imports
    4. Add appropriate comments
    5. Consider edge cases`;

    const prompt = `
    Issue Title: ${issueTitle}
    Issue Body: ${issueBody}

    ${context.existingCode ? `Existing Code:\n${context.existingCode}` : ''}

    Please generate the implementation for this request.
    Format your response as:

    FILE: [filename]
    \`\`\`language
    [code]
    \`\`\`

    You can include multiple files if needed.
    `;

    return await this.callClaude(prompt, systemPrompt);
  }

  /**
   * GitHubにコメントを投稿
   */
  async postComment(owner, repo, issueNumber, body) {
    try {
      await this.octokit.issues.createComment({
        owner,
        repo,
        issue_number: issueNumber,
        body
      });
      console.log(`Posted comment to issue #${issueNumber}`);
    } catch (error) {
      console.error('Failed to post comment:', error);
      throw error;
    }
  }

  /**
   * PRを作成
   */
  async createPullRequest(owner, repo, issueNumber, changes) {
    try {
      const branchName = `claude-fix-${issueNumber}-${Date.now()}`;

      // デフォルトブランチを取得
      const { data: repoData } = await this.octokit.repos.get({ owner, repo });
      const baseBranch = repoData.default_branch;

      // ベースブランチのSHAを取得
      const { data: refData } = await this.octokit.git.getRef({
        owner,
        repo,
        ref: `heads/${baseBranch}`
      });

      // 新しいブランチを作成
      await this.octokit.git.createRef({
        owner,
        repo,
        ref: `refs/heads/${branchName}`,
        sha: refData.object.sha
      });

      // ファイルの変更をコミット
      for (const change of changes) {
        // 既存ファイルの内容を取得（存在する場合）
        let currentSha = null;
        try {
          const { data: fileData } = await this.octokit.repos.getContent({
            owner,
            repo,
            path: change.path,
            ref: branchName
          });
          currentSha = fileData.sha;
        } catch (e) {
          // ファイルが存在しない場合は新規作成
        }

        // ファイルを作成または更新
        await this.octokit.repos.createOrUpdateFileContents({
          owner,
          repo,
          path: change.path,
          message: `Update ${change.path} for issue #${issueNumber}`,
          content: Buffer.from(change.content).toString('base64'),
          branch: branchName,
          sha: currentSha
        });
      }

      // PRを作成
      const { data: pr } = await this.octokit.pulls.create({
        owner,
        repo,
        title: `Fix: Issue #${issueNumber}`,
        head: branchName,
        base: baseBranch,
        body: `## 🤖 Automated PR by Claude AI\n\nThis PR addresses Issue #${issueNumber}\n\n### Changes Made:\n${changes.map(c => `- Modified \`${c.path}\``).join('\n')}\n\n### Note:\nThis PR was automatically generated. Please review carefully before merging.`,
        draft: true
      });

      console.log(`Created PR #${pr.number}`);
      return pr.number;
    } catch (error) {
      console.error('Failed to create PR:', error);
      throw error;
    }
  }

  /**
   * ファイル変更の解析
   */
  parseCodeChanges(implementation) {
    const changes = [];
    const fileRegex = /FILE:\s*(.+)\n```[\w]*\n([\s\S]*?)```/g;

    let match;
    while ((match = fileRegex.exec(implementation)) !== null) {
      changes.push({
        path: match[1].trim(),
        content: match[2]
      });
    }

    return changes;
  }
}

// CLIとして実行する場合
async function main() {
  const action = process.env.ACTION || 'respond';
  const assistant = new ClaudeAssistant(
    process.env.ANTHROPIC_API_KEY,
    process.env.GITHUB_TOKEN
  );

  const owner = process.env.REPO_OWNER;
  const repo = process.env.REPO_NAME;
  const issueNumber = parseInt(process.env.ISSUE_NUMBER);
  const issueTitle = process.env.ISSUE_TITLE;
  const issueBody = process.env.ISSUE_BODY || process.env.COMMENT_BODY;

  try {
    if (action === 'respond') {
      // 単純な応答
      const response = await assistant.callClaude(
        `GitHub Issue: ${issueTitle}\n\n${issueBody}\n\nPlease provide helpful guidance.`
      );

      await assistant.postComment(
        owner,
        repo,
        issueNumber,
        `## 🤖 Claude AI Response\n\n${response}`
      );
    } else if (action === 'implement') {
      // 実装を生成してPRを作成
      const analysis = await assistant.analyzeRequest(issueTitle, issueBody);

      await assistant.postComment(
        owner,
        repo,
        issueNumber,
        `## 📋 Analysis\n\n**Action Type:** ${analysis.action_type}\n**Complexity:** ${analysis.complexity}\n**Summary:** ${analysis.summary}\n\nGenerating implementation...`
      );

      if (analysis.action_type === 'implement' || analysis.action_type === 'document') {
        const implementation = await assistant.generateImplementation(
          issueTitle,
          issueBody
        );

        const changes = assistant.parseCodeChanges(implementation);

        if (changes.length > 0) {
          const prNumber = await assistant.createPullRequest(
            owner,
            repo,
            issueNumber,
            changes
          );

          await assistant.postComment(
            owner,
            repo,
            issueNumber,
            `## ✅ Pull Request Created\n\nI've created PR #${prNumber} with the proposed changes.\n\nPlease review and provide feedback.`
          );
        }
      }
    }
  } catch (error) {
    console.error('Error:', error);
    await assistant.postComment(
      owner,
      repo,
      issueNumber,
      `## ❌ Error\n\nAn error occurred: ${error.message}\n\nPlease check the logs for more details.`
    );
    process.exit(1);
  }
}

// モジュールとして使用する場合はエクスポート
module.exports = ClaudeAssistant;

// 直接実行された場合
if (require.main === module) {
  main().catch(console.error);
}