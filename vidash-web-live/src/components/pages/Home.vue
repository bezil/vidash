<script lang="ts" setup>
import useHomePage from '@/composables/useHomePage.ts'

const {
  initializeHomePage,
} = useHomePage()

initializeHomePage()
</script>

<template>
<div class="flex flex-row w-full h-full">
  <div class="w-full glitch-wrapper">

  <div class="glitch-embed-wrap">
    <iframe
      src="https://glitch.com/embed/#!/embed/spiral-wool-angle?path=README.md&previewSize=100&attributionHidden=true"
      title="Go Translate"
      allow="geolocation; microphone; camera; midi; encrypted-media; xr-spatial-tracking; fullscreen"
      allowFullScreen
      style="height: 100%; width: 100%; border: 0;"
      onload="this.contentWindow.focus();">
    </iframe>
  </div>
  </div>
</div>
</template>

<style scoped>
.glitch-wrapper {
  height: calc(100vh - 60px);
  overflow: hidden;
}
.glitch-embed-wrap {
  height: 100vh;
  width: 100vw;
}
</style>
