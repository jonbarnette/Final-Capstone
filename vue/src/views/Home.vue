<template>
  <div class="bgimg">
    
    <div class="frontpageCats">
      <div class="cats">
        <img class="catpic" src="../Assets/CatUsers/HomepageCat.jpg" />
        <p id="work1">Hi I'm looking for work!</p>
      </div>

      <div class="cats2">
        <img class="catpic" src="../Assets/CatUsers/HomepageCat2.jpg" />
        <p id="work2">Do you have a position open?</p>
      </div>
      
    </div>
    <!-- <video autoplay muted loop id="myVideo">
      <source src="../Assets/computer_cat.mp4" type="video/mp4" />
    </video> -->
    <div class="cta">
      <p>
        At TabbyPro we don’t give up on our feline companions, rather we commit
        our services to their future and continued success
      </p>
    </div>
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

.catpic {
  /* flex: 0 1 30%; */
  align-items: space-around;
  justify-content: center;
  align-content: center;
  margin: 10px;
  transition: transform 1.1s ease 0s;
  border: 1.5px solid black;
}

.catpic:hover {
  transform: scale(1.015);
}

.cats {
  display: flex;
  flex-direction: column;
  width: 50%;
}

.cats2 {
  display: flex;
  flex-direction: column;
  width: 50%;
}

/* .cats:hover {
  transform: scale(1.02);
}

.cats2:hover {
  transform: scale(1.02);
} */

#work1 {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  align-content: center;
  align-self: center;
  position: absolute;
  text-align: center;
  color: white;
  background-color: transparent;
  font-size: 24px;
  font-weight: bold;
  /* transform: translate(-50% ,-50%); */
}
#work2 {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  align-content: center;
  align-self: center;
  position: absolute;
  text-align: center;
  color: white;
  background-color: transparent;
  font-size: 24px;
  font-weight: bold;
  /* transform: translate(-50% ,-50%); */
}

.cta {
  display:flex;
  justify-content: center;
  font-family: "Work Sans",sans-serif;
  text-transform:uppercase;
  font-size: 30px;

}
</style>
