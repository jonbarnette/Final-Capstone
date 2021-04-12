<template>
  <div class="bgimg">
    <video autoplay muted loop id="myVideo">
    <source src="../Assets/computer_cat.mp4" type="video/mp4">
    </video>
  </div>
</template>

<script>
export default {
  name: "home"
};

</script>

<style>


/* Style the video: 100% width and height to cover the entire window */
#myVideo {
  width: 99.67vw;
    height: 600px;
    object-fit: cover;
    z-index: -100;
    margin-left: -50%;
    margin-right: -50%;
}
.bgimg {
  text-align: center;
}
</style>
