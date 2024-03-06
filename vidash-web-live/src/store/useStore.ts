import { computed, ref } from 'vue';
import { User, Server, Member } from '@/types/common.ts'
import { defineStore } from 'pinia'

const user = ref<User>();
const member = ref<Member>();
const server = ref<Server[]>()

const useStore = defineStore('common', () => {
    const account_id = ref(localStorage.getItem('auth_id'))
    const auth_token = ref(localStorage.getItem('token'))

    const isAuthenticated = computed(
        () => localStorage.getItem('token') && account_id.value
    )

    const storeUserDetails = (userDetails: User) => {
        user.value = userDetails
    }

    const storeServerDetails = (servers: Server[]) => {
        server.value = servers
    }

    const storeMemberDetails = (member_value: Member) => {
        member.value = member_value
    }

    const resetStore = () => {
        user.value = undefined
        server.value = []
        member.value = undefined
    }

    return {
        auth_token,
        isAuthenticated,
        account_id,
        user,
        server,
        member,
        storeUserDetails,
        storeServerDetails,
        storeMemberDetails,
        resetStore,
    }
})

export default useStore
