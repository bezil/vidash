import { createClient,
  type Room,
} from "@liveblocks/client";

export const client = createClient({
  publicApiKey: process.env.NEXT_PUBLIC_LIVEBLOCKS_PUBLIC_KEY ?? '',
  throttle: 16,
});

// Presence represents the properties that exist on every user in the Room
// and that will automatically be kept in sync. Accessible through the
// `user.presence` property. Must be JSON-serializable.
export type Presence = {
    cursor: { x: number; y: number } | null;
    message: string | null;
    name: string;
    avatar: string;
  };

  // Optionally, Storage represents the shared document that persists in the
  // Room, even after all users leave. Fields under Storage typically are
  // LiveList, LiveMap, LiveObject instances, for which updates are
  // automatically persisted and synced to all connected clients.
  export type Storage = {
    // author: LiveObject<{ firstName: string, lastName: string }>,
    // ...
  };

  // Optionally, UserMeta represents static/readonly metadata on each user, as
  // provided by your own custom auth back end (if used). Useful for data that
  // will not change during a session, like a user's name or avatar.
  export type UserMeta = {
    // id?: string,  // Accessible through `user.id`
    // info?: Json,  // Accessible through `user.info`
  };

  // Optionally, the type of custom events broadcast and listened to in this
  // room. Use a union for multiple events. Must be JSON-serializable.
  export type RoomEvent = {
    // type: "NOTIFICATION",
    // ...
  };

  export type LiveProps = {
    presence?: Presence
    connectionId: number
  }

  export type TypedRoom = Room<Presence, Storage, UserMeta, RoomEvent>;
