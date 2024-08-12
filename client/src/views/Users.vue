<template>
  <div>
    <h1>Users</h1>
    <input class="title-input" type="text" placeholder="User Name" v-model="name" />

    <!-- Only render if editing post -->
     <button v-if="isEditing" @click="updateUser">Update</button>
     <button v-if="isEditing" @click="cancelEdit">Cancel</button>

    <!-- Only render if not editing post -->
    <button v-else @click="createUser">Create</button>

    <!-- Render all users -->
    <div v-for="user in users" :key="user.id">
      <p>{{ user.first_name }}</p>
      <button @click="editUser(user.id)">Edit</button>
      <button @click="deleteUser(user.id)">Delete</button>
    </div>
  </div>
</template>

<script setup>
  import { ref, onMounted, onBeforeMount } from 'vue'
  import { plainAxiosInstance } from '../axios.js'

  const users = ref([])

  const name = ref('')
  const user_id = ref(0)
  const isEditing = ref(false)
  const API_URL = 'http://localhost:3000/api/v1/users'


  const createUser = async() => {
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: name.value
      })
    })

    const data = await response.json()

    users.value.push(data)
    name.value = ''
    user_id.value = 0
  }

  onMounted(async() => {
    const response = await plainAxiosInstance.get('/api/v1/users')
    users.value = await response.json()
  })

  const updateUser = async() => {
    const response = await fetch(`${API_URL}/${user_id.value}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        id: user_id.value,
        name: name.value
      })
    })

    const data = await response.json()

    const index = users.value.findIndex(user => user.id === user_id.value)
    users.value[index] = data

    name.value = ''
    user_id.value = 0
    isEditing.value = false
  }

  const cancelEdit = () => {
    name.value = ''
    user_id.value = 0
    isEditing.value = false
  }

  const deleteUser = async(id) => {
    const response = await fetch(`${API_URL}/${id}`, {
      method: 'DELETE'
    })

    users.value = users.value.filter(user => user.id !== id)
  }

  const editUser = (id) => {
    const user = users.value.find(user => user.id === id)
    name.value = user.name
    user_id.value = user.id
    isEditing.value = true

    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    })
  }
</script>
