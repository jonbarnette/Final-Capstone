<template>
  <div id="app">
    <div id="nav">

      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <router-link v-bind:to="{name:'cats'}">Cat List</router-link>
    </div>
    <router-view />
    <user-list />
  </div>
</template>

<script>
import UserList from "@/components/UserList.vue";

export default {
  components: {

    UserList
  },
  
    
 };

</script>

