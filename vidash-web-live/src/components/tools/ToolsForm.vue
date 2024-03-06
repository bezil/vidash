<script lang="ts" setup>
import useToolsForm from '@/composables/useToolsForm.ts'

const props = withDefaults(defineProps<{
  type: string
}>(), {
})

console.log(props.type)

const {
  initializeToolsForm,
} = useToolsForm()

initializeToolsForm()
</script>

<template>
<div class="flex flex-row w-full h-full">
  <div class="w-full">

  </div>
</div>
</template>

<style scoped>

</style>
