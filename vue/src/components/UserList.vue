<template>
  <div>
    
    <user-display
    v-for="cat in filteredCats"
    v-bind:key="cat.name"
    v-bind:user="user"
    />
  </div>
</template>

<script>
import UserDisplay from '@/components/UserDisplay.vue'


export default {
  name: 'user-list',
  components: {
    UserDisplay
    
  
  },

  
};
</script>

<style>




</style>