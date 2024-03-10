export type User = {
    id: string,
    full_name: string,
    gender?: string,
    bio?: string,
    avatar?: string,
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

export type Image = {
    public_id?: string,
    width?: string,
    height?: string,
    secure_url?: string,
}

export type Role = 'GUEST' | 'ADMIN' | 'MODERATOR'

export type NavigationItem = {
    id: string,
    title: string,
    subtitle?: string,
}
