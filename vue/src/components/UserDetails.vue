<template>
  <div>
  
    <div class="placeFrequented">
      <h3>List Of Places Frequented</h3>

      <p>Places placeholder</p>
    </div>
  <div class="summaryDetail">
      <h3>Cat Summary</h3>
    </div>
    <div id="userBio">
      <!-- <div>Name:{{ cat.name }}</div> -->

      <div>Lives</div>
      <div>Occupation</div>
      <div>Breed</div>
      <div>Color</div>
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
    
  },
  created() {
      catService.getCatDetails().then((response) => {
        this.catsArray = response.data;
      });
    },
};
</script>



<style scoped>
*, .placeFrequented {
  background-color: #16ffbd;
  color: #060e33!important;
}

.image {
  display: block;
  width: 100%;
  height: auto;
}

</style>