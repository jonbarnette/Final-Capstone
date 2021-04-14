<template>
<div>
    <h1>MEET THE TEAM!!!</h1>
    <div class="missionstatement">
      <p>Since 2021 TabbyPro has united more than 600,000 cats with employers across the country. 
      Our mission is to connect hardworking job seeking cats with the purrrfect company they love. 
      We do this by helping cats get off the streets and getting them connected with their next great employment opportunity. 
      At TabbyPro we don’t give up on our feline companions, rather we commit our services to their future and continued success.
      </p>
      </div>
<div class="theteam">
  
  <div class="joncat">the jon this is just here to see how far it will go
      <img src="../Assets/CatUsers/1017.jpg" />
  </div>
  <div class="charliecat">the charlie this is just here to see how far it will go
      <img src="../Assets/CatUsers/1017.jpg" />
  </div>
  <div class="joecat">the joe this is just here to see how far it will go
      <img src="../Assets/CatUsers/1017.jpg" />
  </div>
  <div class="bugeater">the bugeater this is just here to see how far it will go
      <img src="../Assets/CatUsers/1017.jpg" />
  </div>
  
</div>
</div>
</template>

<script>


export default {
    name: 'about-us',
}

</script>

<style scoped>
h1 {
    text-align: center;
    margin: 10px 0 70px 0;
}
.theteam {
    /* box-sizing: border-box; */
    display: grid;
    grid-template-areas:    'joncat  charliecat'
                            'joecat  bugeater';
    margin-right: 50px;
    margin-left: 50px;
}
.joncat {
    display: flex;
    flex-direction: column;
    grid-area: joncat;
    border: 2px solid black;
    justify-content: center;
    text-align: center;
    margin-right: 10px;
}
.charliecat {
    display: flex;
    flex-direction: column;
    grid-area: charliecat;
    border: 2px solid black;
    justify-content: center;
    text-align: center;
    margin-left: 10px;
}
.joecat {
    display: flex;
    flex-direction: column;
    grid-area: joecat;
    border: 2px solid black;
    justify-content: center;
    text-align: center;
    margin-right: 10px;
}
.bugeater {
    display: flex;
    flex-direction: column;
    grid-area: bugeater;
    border: 2px solid black;
    justify-content: center;
    text-align: center;
    margin-left: 10px;
}



</style>