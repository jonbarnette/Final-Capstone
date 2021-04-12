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

<<<<<<< HEAD

=======
/* Style the video: 100% width and height to cover the entire window */
 #myVideo {
    width: 100%;
    height: 600px;
    object-fit: cover;
    z-index: -100;
    } 

    
>>>>>>> e8834a49281f6147a95e4dd6cb4efd0ff99a214b
</style>
