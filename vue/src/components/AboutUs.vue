<template>
  <div>
    <h1>MEET THE TEAM!!!</h1>

    <div class="theteam">
      <div class="joncat">
        The joncat, looks menacing and does not pay attention at all times. Needs constant naps.
        <img src="../Assets/CatUsers/3001.jpg" />
      </div>
      <div class="charliecat">
        Just like the image, this cat is calm, cool and collected. Nothing could disturb this cat's zen.
        <img src="../Assets/CatUsers/3002.jpg" />
      </div>
      <div class="joecat">
        Stuff should go here explaining what this cat does, but nothing came to mind.
        <img src="../Assets/CatUsers/3003.jpg" />
      </div>
      <div class="bugeater">
        The resident bug eater. Enjoys searching for bugs in the code making it so there is always clean code.
        <img src="../Assets/CatUsers/3000.jpg" />
      </div>
      <div class="missionstatement">
        <p>
          Since 2021 TabbyPro has united more than 600,000 cats with employers
          across the country. Our mission is to connect hardworking job seeking
          cats with the purrrfect company they love. We do this by helping cats
          get off the streets and getting them connected with their next great
          employment opportunity. At TabbyPro we don’t give up on our feline
          companions, rather we commit our services to their future and
          continued success.
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "about-us",
};
</script>

<style scoped>
img {
  border-radius: 50%;
  border: 5px solid black;
}
h1 {
  font-family: "Work Sans",sans-serif;
  font-size: 5rem;
  text-align: center;
  margin: 50px 0 70px 0;
}
.theteam {
  /* box-sizing: border-box; */
  display: grid;
  grid-template-areas:
    "joncat missionstatement charliecat"
    "joecat missionstatement bugeater";
  margin-left: 50px;
  margin-right: 50px;
  margin-bottom: 150px;
}
.joncat {
  display: flex;
  flex-direction: column;
  grid-area: joncat;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-right: 10px;
  margin-bottom: 30px;
  font-size: 2rem;
  font-family: "Ledger", serif;
}
.charliecat {
  display: flex;
  flex-direction: column;
  grid-area: charliecat;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-left: 10px;
  margin-bottom: 30px;
  font-size: 2rem;
  font-family: "Ledger", serif;
}
.joecat {
  display: flex;
  flex-direction: column;
  grid-area: joecat;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-right: 10px;
  margin-top: 30px;
  font-size: 2rem;
  font-family: "Ledger", serif;
}
.bugeater {
  display: flex;
  flex-direction: column;
  grid-area: bugeater;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-left: 10px;
  margin-top: 30px;
  font-size: 2rem;
  font-family: "Ledger", serif;
}
.missionstatement {
  font-family: "Ledger", serif;
  font-size: 1.8rem;
  text-align: center;
  padding-left: 100px;
  padding-right: 100px;
}
</style>