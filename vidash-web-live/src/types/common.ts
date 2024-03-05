export type User = {
    full_name: string,
    id: string,
}

export type Server = {
    name: string,
    image_url?: string,
    id?: string,
}

export type Member = {
    id: string,
    role?: string,
}

export type Role = 'GUEST' | 'ADMIN' | 'MODERATOR'
