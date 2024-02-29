import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from "path"
import tailwind from "tailwindcss"
import autoprefixer from "autoprefixer"
import dotenv from 'dotenv';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  define: {
    'process.env': JSON.stringify(dotenv.config().parsed),
  },
  css: {
    postcss: {
      plugins: [tailwind(), autoprefixer()],
    },
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
