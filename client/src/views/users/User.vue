<template>
  <main class="px-6">
    <div class="max-w-sm mx-auto mt-20">
      <div>
        <label for="weeks" class="text-center block mb-2 text-sm font-medium text-gray-900">{{ user.first_name }} {{ user.last_name }}</label>
        <select @change="checkMonitoringRequests" id="user-weeks" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
          <option value="">Selecciona una semana</option>
          <option v-for="week in weeks" :key="week.week" :value="week.start_date">
            <div class="flex flex-col">
              {{ week.friendly_week_year }} - {{ week.friendly_name }}
            </div>
          </option>
        </select>
      </div>
      <div>
        <label for="availabilities" class="block mt-6 mb-2 text-sm font-medium text-gray-900">Disponibilidad</label>
        <ul role="list" class="grid grid-cols-1 lg:grid-flow-col gap-3">
          <li v-for="availability in availabilities" :key="availability.id" class="col-span-1 divide-y divide-gray-200 rounded-lg bg-white shadow border-2">
            <div class="flex w-full items-center space-x-6 p-6">
              <div class="flex-1 truncate">
                <div class="flex flex-col items-center space-x-3">
                  <h3 class="truncate text-sm font-medium text-gray-900">{{ availability.start_day }} - {{ availability.end_day }}</h3>
                  <p class="truncate text-sm font-medium text-gray-900">{{ formatTimeUTC(availability.start_time) }} - {{ formatTimeUTC(availability.end_time) }}</p>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <div v-if="selectedWeek" class="my-3">
      <ul role="list" class="grid grid-cols-1 gap-x-6 gap-y-8 lg:grid-cols-3 xl:gap-x-8">
        <li v-for="(monitoring_requests, day) in monitoring_requests_by_day" :key="day" class="overflow-hidden rounded-xl border border-gray-200">
          <div class="flex items-center justify-center border-b border-gray-900/5 bg-gray-50 p-6">
            <p class="text-sm font-medium leading-6 text-gray-900">{{ day }}</p>
          </div>
          <dl v-if="monitoring_requests.length > 0" class="-my-3 divide-y divide-gray-100 px-6 py-4 text-sm leading-6">
            <div v-for="monitoring_request in monitoring_requests" :key="monitoring_request.id" class="flex justify-between gap-x-4 py-3">
              <dt class="text-gray-700"><time :datetime="monitoring_request.start_time">{{ formatTimeUTC(monitoring_request.start_time) }} - {{ formatTimeUTC(monitoring_request.end_time) }}</time></dt>
              <dt class="text-gray-500">Servicio xyz</dt>
            </div>
          </dl>
          <p v-else class="px-6 py-4 text-gray-500">No hay asignaciones</p>
        </li>
      </ul>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { format } from 'date-fns'
import { useRouter } from 'vue-router'
import axiosSecureInstance from '../../axios.js'

const router = useRouter()

const user_id = ref(router.currentRoute.value.params.id)
const user = ref({})
const availabilities = ref([])
const monitoring_requests = ref([])
const monitoring_requests_by_day = ref({
  Lunes: [],
  Martes: [],
  Miercoles: [],
  Jueves: [],
  Viernes: [],
  Sabado: [],
  Domingo: []
})
const weeks = ref([])
const selectedWeek = ref('')

onMounted(() => {
  axiosSecureInstance.get(`/api/v1/users/${user_id.value}`)
    .then(response => {
      user.value = response.data.user
      weeks.value = response.data.weeks
      availabilities.value = response.data.availabilities
    })
    .catch(error => {
      console.error(error)
      router.push('/users')
    })
})

const checkMonitoringRequests = async (event) => {
  const date = event.target.value
  selectedWeek.value = date
  if (!date) return
  try {
    const response = await axiosSecureInstance.get(`/api/v1/users/${user_id.value}/monitoring_requests?date=${date}`)
    const data = response.data
    const data_monitoring_requests_by_day = data.monitoring_requests_by_day

    monitoring_requests.value = data.monitoring_requests

    monitoring_requests_by_day.value.Lunes = data_monitoring_requests_by_day.Monday || []
    monitoring_requests_by_day.value.Martes = data_monitoring_requests_by_day.Tuesday || []
    monitoring_requests_by_day.value.Miercoles = data_monitoring_requests_by_day.Wednesday || []
    monitoring_requests_by_day.value.Jueves = data_monitoring_requests_by_day.Thursday || []
    monitoring_requests_by_day.value.Viernes = data_monitoring_requests_by_day.Friday || []
    monitoring_requests_by_day.value.Sabado = data_monitoring_requests_by_day.Saturday || []
    monitoring_requests_by_day.value.Domingo = data_monitoring_requests_by_day.Sunday || []
  } catch (error) {
    console.error(error)
  }
}

const formatTimeUTC = (dateString) => {
  const date = new Date(dateString)
  const hours = date.getUTCHours().toString().padStart(2, '0')
  const minutes = date.getUTCMinutes().toString().padStart(2, '0')
  return `${hours}:${minutes}`
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return format(date, 'dd/MM/yyyy')
}
</script>