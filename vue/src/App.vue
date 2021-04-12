<template>
  
  <div id="app">
    <div>
    <the-header></the-header>
    </div>
    
  
    <div>
    <the-footer></the-footer>
    </div>
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
  color: #163da1;
  background-color: #d6dae6;
}


</style>
