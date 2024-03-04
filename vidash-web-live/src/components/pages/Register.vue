<script setup lang="ts">
import { ref } from 'vue'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import axios from '@/axios'
import { useToast } from '@/components/ui/toast/use-toast'
import { Button } from '@/components/ui/button'
import { Loader2 } from 'lucide-vue-next'

import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import router from '@/router'

const { toast } = useToast()
const isLoading = ref(false)

const formSchema = toTypedSchema(
  z.object({
    username: z.string().min(2).max(50),
    email:  z.string().email(),
    password: z.string().min(8),
    confrimPassword:  z.string().min(8)
  })
  .refine((data) => data.password === data.confrimPassword, {
    message: "Passwords don't match",
    path: ["confrimPassword"], // path of error
  })
)

const form = useForm({
  validationSchema: formSchema,
})

type signupParams = {
  email?:  string,
  password?: string,
  username?: string,
};

const fetchAuthToken = (paramObject: signupParams) => {
  isLoading.value = true

  axios.post('api/signup', {
        account: {
            email: paramObject.email,
            hashed_password: paramObject.password,
            full_name: paramObject.username,
            gender: null,
            avatar: null,
            bio: null
        }
    })
    .then(() => {
      isLoading.value = false

      form.resetForm()
      router.push("/signin")
      toast({
        description: 'Registered Successfully. Please login now',
      });
    })
    .catch(error => console.error('Error:', error));
}

const redirectToLogin = () => {
  router.push("/signin")
}

const onSubmit = form.handleSubmit((values) => {
  fetchAuthToken(values)
})
</script>

<template>
    <div class="place-items-center grid h-full pt-8">
        <form class="flex flex-col gap-y-4 w-full text-left -mt-16
            max-w-sm border border-grey rounded-md p-8" @submit.prevent="onSubmit">
        <p class="text-3xl pb-2">Register</p>
        <FormField v-slot="{ componentField }" name="username">
        <FormItem>
            <FormLabel>Full Name</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input full name" v-bind="componentField" />
            </FormControl>
            <FormMessage />
        </FormItem>
        </FormField>
        <FormField v-slot="{ componentField }" name="email">
        <FormItem>
            <FormLabel>Email Address</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input Email address" v-bind="componentField" />
            </FormControl>
            <FormMessage />
        </FormItem>
        </FormField>
        <FormField v-slot="{ componentField }" name="password">
      <FormItem>
        <FormLabel>Password</FormLabel>
        <FormControl>
          <Input type="password" placeholder="Input password" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>
    <FormField v-slot="{ componentField }" name="confrimPassword">
      <FormItem>
        <FormLabel>Confirm Password</FormLabel>
        <FormControl>
          <Input type="password" placeholder="Confirm password" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <Button v-if="isLoading" disabled>
      <Loader2 class="w-4 h-4 mr-2 animate-spin" />
      Please wait
    </Button>
    <Button v-else type="submit">
      Submit
    </Button>

    <Button variant="ghost" @click="redirectToLogin()">
      Login if account already created
    </Button>
  </form>
    </div>
</template>

<style scoped>
</style>
