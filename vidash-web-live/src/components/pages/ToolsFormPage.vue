<script lang="ts" setup>
import useToolsForm from '@/composables/useToolsForm.ts'
import FillForm from '@/components/form/FillForm.vue'
import RestoreForm from '@/components/form/RestoreForm.vue'
import RecolorForm from '@/components/form/RecolorForm.vue'
import ObjectRemoveForm from '@/components/form/ObjectRemoveForm.vue'
import BackgroundRemoveForm from '@/components/form/BackgroundRemoveForm.vue'

withDefaults(defineProps<{
  type: string
}>(), {
})

const {
  saveToDatabase,
} = useToolsForm()
</script>

<template>
<div class="flex flex-row w-full h-full">
  <div class="text-left w-full md:w-[70%] pt-4">
    <template v-if="type==='fill'">
      <FillForm @image-saved="saveToDatabase($event)"/>
    </template>
    <template v-else-if="type==='restore'">
      <RestoreForm @image-saved="saveToDatabase($event)" />
    </template>
    <template v-else-if="type==='recolor'">
      <RecolorForm @image-saved="saveToDatabase($event)" />
    </template>
    <template v-else-if="type==='obj_remove'">
      <ObjectRemoveForm @image-saved="saveToDatabase($event)" />
    </template>
    <template v-else-if="type==='bg_remove'">
      <BackgroundRemoveForm @image-saved="saveToDatabase($event)" />
    </template>
  </div>
</div>
</template>

<style scoped>

</style>
