<template>
  <div id="userlist">
    <div id="searchUsers">
        <label for="occupation">Search by occupation:</label>
        <input type="text" name="occupation" v-model="occupationFilter" />     
    </div>
    <div class="body">
      <div class="card" v-for="cat in filteredCats" v-bind:key="cat.name" >
        <div>
          <img class="image" v-bind:src="getImageURL(cat.imageName)" />
        </div>
        <div class="info">
        <div class="container">
           <router-link style="text-decoration: none;" v-bind:to="{ name: 'catdetails', params: {id: cat.catId }}">{{cat.name}}</router-link>
          </div>
        <div class="container">
          <h5>{{cat.occupation}}</h5>
          </div>
        <div class="container">"{{cat.tagline}}"</div>

        </div>
  
      </div>
    </div>
  </div>

</template>

<script>

import catService from '@/services/CatService.js';

export default {

  name: "user-list",
  props: ["user"],
data() {
    return {
      occupationFilter: "",
      catsArray: [],
    };
  },
  computed: {
     filteredCats() {
         return this.catsArray.filter((cat) => {  
              console.log(this.occupationFilter);
             return cat.occupation.toLowerCase().includes(this.occupationFilter.toLowerCase());
         });
     }
  },

  methods: {
    getImageURL(pic) {
      return require('../Assets/CatUsers/' + pic);
    },
    viewCatList() {
      this.$router.push('/cats');
    },
  
    toCatDetails() {
      this.$router.push('/catdetails');
    },
  },

  created() {
    catService.getCatList().then((response) => {
      this.catsArray = response.data;
    });
  }
};

</script>

<style>
#userlist {
  margin-bottom: 5em;
  text-align: center;
}

.image {
  width: 100%!important;
   height: 200px!important;
   object-fit: cover!important;
   align-content: center!important;
   justify-content: center!important;
}

.body {
  display: flex;
  flex-flow: row wrap;
  justify-content: center;
  align-items: flex-start;
  align-content: center;

}

.card {
  flex: 0 1 30%;
  align-items: space-around;
  justify-content: center;
  align-content: center;
  margin: 10px;
  box-shadow: 0px 8px 8px 0px grey;
}

.card:hover {
  box-shadow: 0px 8px 8px 0px #163da1;
}

.container {
  align-content: center;
  text-align: center;
  align-items: center;
  justify-content: center;
  margin: 0px;
}

h3, h5 {
  margin: 0px;
}

#main-div {
    margin: 30px;
}
#searchUsers {
    margin: 30px;
}

input[type=text] {
    margin: 30px;
    width: 10%;
    padding: 12px 14px;
    border: 2px solid #163da1;
    border-radius: 6px;
}




</style>