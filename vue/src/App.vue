<template>
  <div id="app">
   <the-header></the-header>
    
    <the-footer></the-footer>
    
  </div>
</template>

<script>


import TheFooter from "@/components/TheFooter.vue";
import TheHeader from "@/components/TheHeader.vue";



export default {
  components: {
    TheHeader,
    TheFooter,
  },
 };

</script>

<style>
* {
  background-color: #163da1;
  color: #c5cada;
}
</style>
