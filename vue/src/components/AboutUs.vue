<template>
  <div>
    <div class="theteam">
      <div class="left">
        <div class="joncat">
          <img src="../Assets/CatUsers/3001.jpg" />
          <p>Jon the cat, looks menacing and does not pay attention at all times. Needs constant naps.</p>
        </div>
        <div class="joecat">
          <img src="../Assets/CatUsers/3003.jpg" />
          <p>Joe knows that stuff should go here explaining what he does, but nothing came to mind.</p>
        </div>
      </div>

      <div class="missionstatement">
        <h2>MEET THE TEAM</h2>
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

      <div class="right">
        <div class="charliecat">
          <img src="../Assets/CatUsers/3002.jpg" />
          <p>Just like the image, Charlie is calm, cool and collected. Nothing could disturb this cat's zen.</p>          
        </div>
        <div class="bugeater">
          <img src="../Assets/CatUsers/3000.jpg" />
          <p>The resident bug eater, Kevin. Enjoys searching for bugs in the code making it so there is always clean code.</p>          
        </div>
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
  display: flex;
  flex-direction: column;
  border-radius: 50%;
  border: 5px solid black;
  vertical-align: center;
  justify-content: center;
  text-align: center;
  align-content: center;
  align-items: center;

}
h2 {
  font-family: "Work Sans",sans-serif;
  font-size: 3.5rem;
  text-align: center;
  margin: 0 0 0 0;
}
p {
  margin: 0 0 0 0;
}
.theteam {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;

}
.joncat {
  display: flex;
  flex-direction: column;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-bottom: 30px;
  font-size: 1.5rem;
  font-family: "Ledger", serif;
}
.charliecat {
  display: flex;
  flex-direction: column;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-bottom: 30px;
  font-size: 1.5rem;
  font-family: "Ledger", serif;
}
.joecat {
  display: flex;
  flex-direction: column;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-top: 30px;
  font-size: 1.5rem;
  font-family: "Ledger", serif;
}
.bugeater {
  display: flex;
  flex-direction: column;
  border: 2px solid transparent;
  justify-content: center;
  text-align: center;
  margin-top: 30px;
  font-size: 1.5rem;
  font-family: "Ledger", serif;
}
.missionstatement {
  font-family: "Ledger", serif;
  font-size: 1.8rem;
  text-align: center;
  padding-left: 50px;
  padding-right: 50px;
  align-self: center;
  width: 50%;
}
.left, .right {
  width: 25%;
}
</style>