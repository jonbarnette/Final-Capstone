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
  background-color: #5680E9;
  color: #C1C8E4;
}
</style>
