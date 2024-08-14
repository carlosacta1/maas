<template>
  <main class="px-6">
    <div class="flex gap-3">
      <form v-if="isCreatiningService" @submit.prevent="createService" class="col-span-1 divide-y divide-gray-200 rounded-lg bg-white shadow">
        <div class="isolate p-6 -space-y-px rounded-md shadow-sm">
          <div class="relative rounded-md rounded-b-none px-3 pb-1.5 pt-2.5 ring-1 ring-inset ring-gray-300 focus-within:z-10 focus-within:ring-2 focus-within:ring-indigo-600">
            <label for="service-name" class="block text-xs font-medium text-gray-900">Nombre</label>
            <input type="text" name="service-name" id="service-name" class="block w-full border-0 p-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" v-model="name">
          </div>
          <div class="relative rounded-md rounded-b-none px-3 pb-1.5 pt-2.5 ring-1 ring-inset ring-gray-300 focus-within:z-10 focus-within:ring-2 focus-within:ring-indigo-600">
            <label for="service-description" class="block text-xs font-medium text-gray-900">Descripción</label>
            <input type="text" name="service-description" id="service-description" class="block w-full border-0 p-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" v-model="description">
          </div>
        </div>
        <div>
          <div class="-mt-px flex divide-x divide-gray-200">
            <div class="flex w-0 flex-1">
              <button type="submit" class="relative -mr-px inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-bl-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                </svg>
                Crear
              </button>
            </div>
            <div class="-ml-px flex w-0 flex-1">
              <button @click="cancelCreateService" class="relative inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-br-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m5.231 13.481L15 17.25m-4.5-15H5.625c-.621 0-1.125.504-1.125 1.125v16.5c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Zm3.75 11.625a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
                </svg>
                Cancelar
              </button>
            </div>
          </div>
        </div>
      </form>
      <button v-else @click="newService" type="button" class="gap-2 px-3 py-2 text-xs font-medium text-center inline-flex items-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300">
        <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
          <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 4h3a1 1 0 0 1 1 1v15a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1h3m0 3h6m-3 5h3m-6 0h.01M12 16h3m-6 0h.01M10 3v4h4V3h-4Z"/>
        </svg>
        Crear servicio
      </button>
    </div>
    <ul role="list" class="grid grid-cols-1 gap-6 mx-auto mt-20 max-w-7xl sm:grid-cols-2 lg:grid-cols-3">
      <li v-for="service in services" :key="service.id" class="col-span-1 divide-y divide-gray-200 rounded-lg bg-white shadow border-2">
        <div v-if="service.isEditing" class="isolate p-6 -space-y-px rounded-md shadow-sm">
          <div class="relative rounded-md rounded-b-none px-3 pb-1.5 pt-2.5 ring-1 ring-inset ring-gray-300 focus-within:z-10 focus-within:ring-2 focus-within:ring-indigo-600">
            <label for="service-name" class="block text-xs font-medium text-gray-900">Nombre</label>
            <input type="text" name="service-name" id="service-name" class="block w-full border-0 p-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" v-model="service.name">
          </div>
          <div class="relative rounded-md rounded-t-none px-3 pb-1.5 pt-2.5 ring-1 ring-inset ring-gray-300 focus-within:z-10 focus-within:ring-2 focus-within:ring-indigo-600">
            <label for="service-description" class="block text-xs font-medium text-gray-900">Descripción</label>
            <input type="text" name="service-description" id="service-description" class="block w-full border-0 p-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" v-model="service.description">
          </div>
        </div>
        <div v-else class="flex w-full items-center space-x-6 p-6">
          <div class="flex-1 truncate">
            <div class="flex items-center space-x-3">
              <h3 class="truncate text-sm font-medium text-gray-900 text-center">{{ service.name }}</h3>
            </div>
            <p class="mt-1 truncate text-sm text-gray-500">{{ service.description }}</p>
          </div>
        </div>
        <div>
          <div class="-mt-px flex divide-x divide-gray-200">
            <div class="flex w-0 flex-1">
              <button v-if="service.isEditing" @click="updateService(service.id)" class="relative -mr-px inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-bl-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                </svg>
                Actualizar
              </button>
              <button v-else @click="editService(service)" class="relative -mr-px inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-bl-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                </svg>
                Editar
              </button>
            </div>
            <div class="-ml-px flex w-0 flex-1">
            <button v-if="service.isEditing" @click="cancelEdit(service)" class="relative inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-br-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m5.231 13.481L15 17.25m-4.5-15H5.625c-.621 0-1.125.504-1.125 1.125v16.5c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Zm3.75 11.625a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
              </svg>
              Cancelar
            </button>
            <button v-else @click="goToService(service.id)" class="relative inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-br-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m5.231 13.481L15 17.25m-4.5-15H5.625c-.621 0-1.125.504-1.125 1.125v16.5c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Zm3.75 11.625a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
              </svg>
              Ver
            </button>
          </div>
          </div>
        </div>
      </li>
    </ul>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axiosSecureInstance from '../../axios.js'

const router = useRouter()
const services = ref([])
const isCreatiningService = ref(false)
const name = ref('')
const description = ref('')

onMounted(async () => {
  try {
    const response = await axiosSecureInstance.get('/api/v1/services')
    services.value = response.data.map(service => ({ ...service, isEditing: false }))
  } catch (error) {
    console.error(error)
    router.push('/')
  }
})

const editService = (service) => {
  service.isEditing = true
}

const cancelEdit = (service) => {
  service.isEditing = false
}

const updateService = async (id) => {
  const service = services.value.find(service => service.id === id)
  try {
    await axiosSecureInstance.put(`/api/v1/services/${id}`, service)
    service.isEditing = false
  } catch (error) {
    console.error(error)
  }
}

const newService = () => {
  isCreatiningService.value = true
}

const cancelCreateService = () => {
  isCreatiningService.value = false
}

const createService = async () => {
  try {
    const response = await axiosSecureInstance.post('/api/v1/services', { 
      name: name.value,
      description: description.value 
    })
    services.value.push(response.data)
    isCreatiningService.value = false
  } catch (error) {
    console.error(error)
  }
}

const goToService = (id) => {
  router.push(`/services/${id}`)
}
</script>