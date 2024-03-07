<script lang="ts" setup>
import useToolsForm from '@/composables/useToolsForm.ts'
import FillForm from '@/components/tools/FillForm.vue'
import RestoreForm from '@/components/tools/RestoreForm.vue'
import RecolorForm from '@/components/tools/RecolorForm.vue'
import ObjectRemoveForm from '@/components/tools/ObjectRemoveForm.vue'
import BackgroundRemoveForm from '@/components/tools/BackgroundRemoveForm.vue'

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
  <div class="text-left w-[70%] pt-4">
    <template v-if="type==='fill'">
      <FillForm  />
    </template>
    <template v-else-if="type==='restore'">
      <RestoreForm  />
    </template>
    <template v-else-if="type==='recolor'">
      <RecolorForm  />
    </template>
    <template v-else-if="type==='obj_remove'">
      <ObjectRemoveForm  />
    </template>
    <template v-else-if="type==='bg_remove'">
      <BackgroundRemoveForm  />
    </template>
  </div>
</div>
</template>

<style scoped>

</style>
