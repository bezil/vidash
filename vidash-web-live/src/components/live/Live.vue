<script lang="ts" setup>
import useLiveBlocks from '@/composables/useLiveBlocks.ts'
import Livecursors from '@/components/live/cursor/LiveCursors.vue'

const { myPresence, room, others } = useLiveBlocks("my-live-room")

// Update cursor presence to current pointer location
const handlePointerMove = (event: PointerEvent) => {
  room.updatePresence({
    cursor: {
      x: Math.round(event.clientX),
      y: Math.round(event.clientY),
    },
  });
}

// When the pointer leaves the page, set cursor presence to null
const handlePointerLeave = () => {
  room.updatePresence({
    cursor: {},
  });
}
</script>

<template>
  <div class="w-full h-full">
    <div>
    <div v-if="'message' in myPresence">
      <p>{{ myPresence.message }}</p>
    </div>
  </div>
    <Livecursors
      v-if="'cursor' in myPresence"
      :presence="myPresence"
      :others="(others as unknown)"
      class="border-2 border-text w-full h-full"
      @pointer-updated="handlePointerMove($event)"
      @pointer-left="handlePointerLeave"
    />
  </div>
</template>
