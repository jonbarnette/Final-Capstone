<template>
  <div id="nav">
    <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
    <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>&nbsp;|&nbsp;
    <router-link v-bind:to="{ name: 'cats' }">Cat List</router-link>

    <router-view></router-view>
  </div>
  
  
</template>

<script>
export default {};
</script>

<style>

#nav {
    text-align: center;
}
</style>