<script lang="ts" setup>
import { type Presence , type LiveProps } from '@/lib/liveblocks.ts'
import Cursor from '@/components/live/cursor/Cursor.vue'

defineProps<{
  others: LiveProps[] | any
  presence: Presence
}>()

const emit = defineEmits(['pointer-updated', 'pointer-left'])

const COLORS = [
  "#E57373",
  "#9575CD",
  "#4FC3F7",
  "#81C784",
  "#FFF176",
  "#FF8A65",
  "#F06292",
  "#7986CB",
];


</script>

<template>
<div
    class="flex flex-row w-full"
    @pointerleave="emit('pointer-left', $event)"
    @pointermove="emit('pointer-updated', $event)"
>
    <!-- Show the current user's cursor location -->
    <div class="text">
      {{
        presence?.cursor?.x
          ? `${presence.cursor.x} × ${presence.cursor.y}`
          : "Move your cursor to broadcast its position to other people in the room."
      }}
    </div>
      <!-- Iterate through others and show their cursors -->
      <template v-for="other in others">
      <Cursor
        v-if="other.presence?.cursor?.x"
        :color="COLORS[other.connectionId % COLORS.length]"
        :x="other.presence.cursor.x"
        :y="other.presence.cursor.y"
        :message="other.presence.message"
      />
    </template>
</div>
</template>
