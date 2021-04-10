<template>
  <div id="userdetail" @submit.once="deleteCat">
    <div id="userBio" v-for="cat in catsArray" v-bind:key="cat.catId">
      <div>
        <img class="detailImage" v-bind:src="getImageURL(cat.imageName)" />
      </div>
      <div>
        <h2>{{ cat.name }}</h2>
      </div>
      <div>Lives: {{ cat.lives }}</div>
      <div>Breed: {{ cat.breed }}</div>
      <div>Color: {{ cat.color }}</div>
      <div>Occupation: {{ cat.occupation }}</div>
    </div>

    <div
      class="placeFrequented"
      v-for="cat in catsArray"
      v-bind:key="cat.catId"
    >
      <h3>List Of Places Frequented</h3>

      <p>{{ cat.address }}</p>
    </div>
    <div class="summaryDetail" v-for="cat in catsArray" v-bind:key="cat.catId">
      <h3>Cat Summary</h3>
      <p>{{ cat.summary }}</p>
    </div>
    <div class="deleteCats" v-for="cat in catsArray" v-bind:key="cat.catId">
    <button type="submit" class="deleteButton" value="Delete Profile">Delete This Profile</button>
    </div>
  </div>
</template>

<script>
import catService from "@/services/CatService.js";

export default {
  name: "user-details",

  data() {
    return {
      catsArray: [],
    };
  },

  methods: {
    viewCatDetails() {
      this.$router.push("/catdetails");
    },
    getImageURL(pic) {
      return require("../Assets/CatUsers/" + pic);
    },
  },
  created() {
    const catId = this.$store.state.catId;

    catService
      .getCatDetails(catId)
      .then((response) => {
        console.log(response);
        console.log(response.data);

        this.catsArray = response.data;
      })
      .catch((error) => {
        console.log(error.statusMsg);
      });
  },
  deleteCat() {
      const catId = this.$store.state.catId;

      catService
        .deleteCat(catId)
        .then((response) => {
          console.log(response.status);
          if (response.status == "204") {
            //success
            this.$router.push("/");
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error);
        });
  },
};
</script>



<style scoped>
.detailImage {
  display: block;
  width: 300px !important;
  height: auto;
  margin-left: auto;
  margin-right: auto;
  margin-top: 1em;
}
* {
  display:flex;
  flex-direction: column;
}
</style>