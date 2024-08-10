<script setup>
  import { ref, onMounted } from 'vue'

  const employees = ref([])

  const name = ref('')
  const employee_id = ref(0)
  const isEditing = ref(false)
  const API_URL = 'http://localhost:3000/employees'


  const createEmployee = async() => {
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

    employees.value.push(data)
    name.value = ''
    employee_id.value = 0
  }

  const updateEmployee = async() => {
    console.log('Update employee')
  }

  const cancelEdit = () => {
    console.log('Cancel edit')
  }
</script>

<template>
  <div>
    <h1>Employees</h1>
    <input class="title-input" type="text" placeholder="Employee Name" v-model="name" />

    <!-- Only render if editing post -->
     <button v-if="isEditing" @click="updateEmployee">Update</button>
     <button v-if="isEditing" @click="cancelEdit">Cancel</button>

    <!-- Only render if not editing post -->
    <button v-else @click="createEmployee">Create</button>
  </div>
</template>

<style scoped>
.title-input {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    background-color: #f8f8f8;
    color: #111;
    border-radius: 4px;
    resize: vertical;
}

.body-input {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    background-color: #f8f8f8;
    color: #111;
    border-radius: 4px;
    resize: vertical;
}
</style>
