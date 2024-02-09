<script setup lang="ts">
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import axios from '@/axios'

import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import router from '@/router'

const formSchema = toTypedSchema(
  z.object({
    email:  z.string().email(),
    password: z.string(),
  })
)

const form = useForm({
  validationSchema: formSchema,
})

type loginParams = {
  email:  string,
  password: string
};

const login = (paramObject: loginParams) => {
    axios.post('api/signin', {
        email: paramObject.email,
        hashed_password: paramObject.password,
    },{ withCredentials: true })
    .then((response) => {
      localStorage.setItem('token', response.data.token)
      localStorage.setItem('auth_id', response.data.id)

      form.resetForm()
      router.push("/").then(() => router.go(0))
    })
    .catch(error => console.error('Error:', error));
}

const redirectToRegister = () => {
  router.push("/signup")
}

const onSubmit = form.handleSubmit((values) => {
  login(values)
})
</script>

<template>
    <div class="place-items-center grid pt-8">
        <form class="flex flex-col gap-y-4 w-full text-left
            max-w-sm border border-grey rounded-md p-8" @submit.prevent="onSubmit">
        <p class="text-3xl pb-2">Login</p>
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

    <Button type="submit">
      Login
    </Button>
    <Button variant="ghost" @click="redirectToRegister()">
      Signup if account not registered
    </Button>
  </form>
    </div>
</template>

<style scoped>
</style>
