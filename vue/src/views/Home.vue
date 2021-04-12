<template>
  <div class="bgimg">
  <div class="topleft">
    <h2>Tabby Pro Cat Agency</h2>
  </div>
  <div class="middle">
    <h1>COMING SOON</h1>
    <hr>
    <p id="demo" style="font-size:35px"></p>
  </div>
  <div>
  <video autoplay muted loop id="myVideo">
  <source src="../Assets/computer_cat.mp4" type="video/mp4">
  </video>
  </div>
</div>
</template>

<script>
export default {
  name: "home"
};

// Set the date we're counting down to
var countDownDate = new Date("April 16, 2021 9:30:00").getTime();

// Update the count down every 1 second
var countdownfunction = setInterval(function() {

  // Get todays date and time
  var now = new Date().getTime();
  
  // Find the distance between now an the count down date
  var distance = countDownDate - now;
  
  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
  
  // Output the result in an element with id="demo"
  document.getElementById("demo").innerHTML = days + "d " + hours + "h "
  + minutes + "m " + seconds + "s ";
  
  // If the count down is over, write some text 
  if (distance < 0) {
    clearInterval(countdownfunction);
    document.getElementById("demo").innerHTML = "EXPIRED";
  }
}, 1000);

</script>

<style>
/* Style the video: 100% width and height to cover the entire window */
#myVideo {
  width: 99.67vw;
    height: 600px;
    object-fit: cover;
    z-index: -100;
    margin-left: -1%;
    margin-right: -5%;
}
</style>
