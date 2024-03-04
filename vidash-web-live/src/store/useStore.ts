import { computed, ref } from 'vue';
import { User, Server, Member } from '@/types/common.ts'
import { defineStore } from 'pinia'

const useStore = defineStore('common', () => {
    const user = ref<User>();
    const member = ref<Member>();
    const server = ref<Server[]>()
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
        server.value = undefined
        member.value = undefined
    }

    return {
        auth_token,
        isAuthenticated,
        account_id,
        user,
        server,
        storeUserDetails,
        storeServerDetails,
        storeMemberDetails,
        resetStore,
    }
})

export default useStore
