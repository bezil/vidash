<script lang="ts" setup>
import useHomePage from '@/composables/useHomePage.ts'

const {
  initializeHomePage,
} = useHomePage()

initializeHomePage()
</script>

<template>
<div class="flex flex-row w-full server-canvas">
  <div class="w-full">
    <iframe
      src="https://devbez-vidash-live.hf.space"
      frameborder="0"
      width="100%"
      height="100%"
    ></iframe>
  </div>
</div>
</template>

<style scoped>
.server-canvas {
  height: calc(100vh - 80px);
}
</style>
