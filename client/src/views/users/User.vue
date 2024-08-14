<template>
  <main class="px-6">
    <div class="flex gap-3">
      <form v-if="isCreatiningAvailability" @submit.prevent="createAvailability" class="col-span-1 divide-y divide-gray-200 rounded-lg bg-white shadow">
        <div class="isolate p-6 -space-y-px rounded-md shadow-sm">
          <div class="relative rounded-md rounded-b-none px-3 pb-1.5 pt-2.5 ring-1 ring-inset ring-gray-300 focus-within:z-10 focus-within:ring-2 focus-within:ring-indigo-600">
            <label for="start-time" class="block text-xs font-medium text-gray-900">Hora</label>
            <input type="datetime-local" name="start-time" id="start-time" class="block w-full border-0 p-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" v-model="start_time" step="3600">
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
              <button @click="cancelCreateAvailability" class="relative inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-br-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m5.231 13.481L15 17.25m-4.5-15H5.625c-.621 0-1.125.504-1.125 1.125v16.5c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Zm3.75 11.625a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
                </svg>
                Cancelar
              </button>
            </div>
          </div>
        </div>
      </form>
      <button v-else @click="newAvailability" type="button" class="gap-2 px-3 py-2 text-xs font-medium text-center inline-flex items-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300">
        <svg class="w-6 h-6 text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
          <path fill-rule="evenodd" d="M18 5.05h1a2 2 0 0 1 2 2v2H3v-2a2 2 0 0 1 2-2h1v-1a1 1 0 1 1 2 0v1h3v-1a1 1 0 1 1 2 0v1h3v-1a1 1 0 1 1 2 0v1Zm-15 6v8a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-8H3ZM11 18a1 1 0 1 0 2 0v-1h1a1 1 0 1 0 0-2h-1v-1a1 1 0 1 0-2 0v1h-1a1 1 0 1 0 0 2h1v1Z" clip-rule="evenodd"/>
        </svg>
        Crear disponibilidad
      </button>
    </div>
    <div class="max-w-sm mx-auto mt-20">
      <label for="weeks" class="block mb-2 text-sm font-medium text-gray-900">{{ user.first_name }} {{ user.last_name }}</label>
      <select @change="checkAvailabilities" id="countries" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
        <option value="">Selecciona una semana</option>
        <option v-for="week in weeks" :key="week.week" :value="week.start_date">
          <div class="flex flex-col">
            {{ week.friendly_week_year }} - {{ week.friendly_name }}
          </div>
        </option>
      </select>
    </div>
    <div class="my-3">
      <ul role="list" class="grid grid-cols-1 gap-x-6 gap-y-8 lg:grid-cols-3 xl:gap-x-8">
        <li v-for="(availabilities, day) in availabilities_by_day" :key="day" class="overflow-hidden rounded-xl border border-gray-200">
          <div class="flex items-center justify-center border-b border-gray-900/5 bg-gray-50 p-6">
            <p class="text-sm font-medium leading-6 text-gray-900">{{ day }}</p>
          </div>
          <dl v-if="availabilities.length > 0" class="-my-3 divide-y divide-gray-100 px-6 py-4 text-sm leading-6">
            <div v-for="availability in availabilities" :key="availability.id" class="flex justify-between gap-x-4 py-3">
              <dt class="text-gray-500">Hora de Inicio</dt>
              <dd class="text-gray-700"><time :datetime="availability.start_time">{{ availability.start_time }}</time></dd>
            </div>
            <div v-for="availability in availabilities" :key="availability.id" class="flex justify-between gap-x-4 py-3">
              <dt class="text-gray-500">Hora de Fin</dt>
              <dd class="text-gray-700"><time :datetime="availability.end_time">{{ availability.end_time }}</time></dd>
            </div>
          </dl>
          <p v-else class="px-6 py-4 text-gray-500">No hay disponibilidades</p>
        </li>
      </ul>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axiosSecureInstance from '../../axios.js'

const router = useRouter()

const user_id = ref(router.currentRoute.value.params.id)
const user = ref({})
const availabilities = ref([])
const availabilities_by_day = ref({
  Monday: [],
  Tuesday: [],
  Wednesday: [],
  Thursday: [],
  Friday: [],
  Saturday: [],
  Sunday: []
});
const weeks = ref([])
const isCreatiningAvailability = ref(false)
const start_time = ref('')

onMounted(() => {
  axiosSecureInstance.get(`/api/v1/users/${user_id.value}`)
    .then(response => {
      user.value = response.data.user
      weeks.value = response.data.weeks
    })
    .catch(error => {
      console.error(error)
      router.push('/users')
    })
})

const checkAvailabilities = async (event) => {
  const date = event.target.value
  try {
    const response = await axiosSecureInstance.get(`/api/v1/users/${user_id.value}/availabilities?date=${date}`);
    const data = response.data
    const data_availabilities_by_day = data.availabilities_by_day

    availabilities.value = data.availabilities

    availabilities_by_day.value.Monday = data_availabilities_by_day.Monday || [];
    availabilities_by_day.value.Tuesday = data_availabilities_by_day.Tuesday || [];
    availabilities_by_day.value.Wednesday = data_availabilities_by_day.Wednesday || [];
    availabilities_by_day.value.Thursday = data_availabilities_by_day.Thursday || [];
    availabilities_by_day.value.Friday = data_availabilities_by_day.Friday || [];
    availabilities_by_day.value.Saturday = data_availabilities_by_day.Saturday || [];
    availabilities_by_day.value.Sunday = data_availabilities_by_day.Sunday || [];
  } catch (error) {
    console.error(error);
  }
}

const newAvailability = () => {
  isCreatiningAvailability.value = true
}

const cancelCreateAvailability = () => {
  isCreatiningAvailability.value = false
}

const createAvailability = async () => {
  try {
    const response = await axiosSecureInstance.post(`/api/v1/users/${user_id.value}/availabilities`, {
      availability: {
        start_time: start_time.value
      }
    })
    availabilities.value.push(response.data)
    isCreatiningAvailability.value = false
  } catch (error) {
    console.error(error)
  }
}
</script>