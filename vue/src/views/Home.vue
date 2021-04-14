<template>
  <div class="bgimg">
    <div class="frontpageCats">
      <div class="cats">
        <img src="../Assets/CatUsers/HomepageCat.jpg" />
        </div>
      <p id="work1">Hi I'm looking for work!</p>
      <div class="cats">
        <img src="../Assets/CatUsers/AlleyCat.jpg" />
        <p id="work2">Do you have a position open?</p>
      </div>
    </div>
    <video autoplay muted loop id="myVideo">
      <source src="../Assets/computer_cat.mp4" type="video/mp4" />
    </video>
  </div>
</template>

<script>
export default {
  name: "home",
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

.frontpageCats {
  display: flex;
  flex-direction: row;
  
  position: relative;
  background-color: transparent;


  
}

.cats {
  /* flex: 0 1 30%; */
  align-items: space-around;
  justify-content: center;
  align-content: center;
  margin: 10px;
  
  transition: transform 1.2s ease 0s;
  border: 5px solid black;
  object-fit: cover;
}



.cats:hover {
transition-delay: .1s;
 transform: scale(1.02);
}

#work1 {
  position: absolute;
  top: 25%;
  left: 45%;
  z-index: 100;
  color:white;
  background-color: transparent;
  font-size: 24px;
  font-weight: bold;
  transform: translate(-50% ,-50%);
  overflow: auto;
  
  
}
#work2 {
  position: absolute;
  top: 40%;
  right: 1%;
  z-index: 100;
  color:white;
  background-color: transparent;
  font-size: 24px;
  font-weight: bold;
  transform: translate(-50% ,-50%);
  overflow:auto;
  
}



</style>
