const js = require('@eslint/js')
const tseslint = require('@typescript-eslint/eslint-plugin')
const tsparser = require('@typescript-eslint/parser')
const importPlugin = require('eslint-plugin-import')

module.exports = [
  js.configs.recommended,
  {
    files: ['**/*.ts', '**/*.tsx'],
    languageOptions: {
      parser: tsparser,
      parserOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
        project: './tsconfig.json',
      },
      globals: {
        // Node.js環境のグローバル変数
        exports: 'writable',
        process: 'readonly',
        console: 'readonly',
        __dirname: 'readonly',
        require: 'readonly',
        // Firebase環境のグローバル変数
        FirebaseFirestore: 'readonly',
      },
    },
    plugins: {
      '@typescript-eslint': tseslint,
      import: importPlugin,
    },
    rules: {
      ...tseslint.configs.recommended.rules,
      'import/no-unresolved': 'off',
      'valid-jsdoc': 'off',
      'require-jsdoc': 'off',
      camelcase: 'off',
      'no-redeclare': 'off',
      '@typescript-eslint/no-require-imports': 'off',
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-unused-vars': 'warn',
      indent: 'off',
      quotes: 'off',
      semi: 'off',
      'no-undef': 'warn',
      'no-console': 'warn',
    },
  },
  {
    ignores: ['lib/**', 'node_modules/**', '*.js'],
  },
]
