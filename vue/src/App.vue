<template>
  
  <div id="app">
    <div>
    <the-header></the-header>
    </div>
    <!-- The video -->
  <div>
  <video autoplay muted loop id="myVideo">
  <source src="../src/Assets/computer cat.mp4" type="video/mp4">
  </video>
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
  background-color: #163da1;
  color: #c5cada;
}

/* Style the video: 100% width and height to cover the entire window */
#myVideo {
  width: 100%;
    height: 600px;
    object-fit: cover;
    z-index: -100;
}
</style>
