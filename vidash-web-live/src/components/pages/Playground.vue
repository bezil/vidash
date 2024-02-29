<script lang="ts" setup>
import useStore from '@/store/useStore'

const { isAuthenticated } = useStore()
</script>

<template>
<div class="flex flex-row w-full h-full">
  <div class="w-full">
    <iframe
      :src="isAuthenticated
        ? 'https://devbez-vidash-live.hf.space'
        : 'https://hftools-inference-api.hf.space'"
      frameborder="0"
      width="100%"
      height="100%"
    ></iframe>
  </div>
</div>
</template>
