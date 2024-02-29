import { client, type Presence } from '@/lib/liveblocks.ts'
import { onUnmounted, ref } from "vue";

const useLiveBlocks = (
    roomName: string,
) => {
    const { room, leave } = client.enterRoom(roomName, { initialPresence: {
        cursor: {},
        message: '',
    } });

    const myPresence = ref<Presence | {}>(room.getPresence());

    const others = ref(room.getOthers());
    const othersCount = ref(room.getOthers().length);

    const unsubscribeOthers = room.subscribe("others", (updatedOthers) => {
        othersCount.value = updatedOthers.length;
        others.value = updatedOthers as any;
    });

    const unsubscribeMyPresence = room.subscribe("my-presence", (newPresence) => {
        myPresence.value = newPresence;
    });


    onUnmounted(() => {
        unsubscribeOthers();
        unsubscribeMyPresence();
    });

    return {
        room,
        others,
        othersCount,
        myPresence,
        leave,
    }
}

export default useLiveBlocks
