<template>
  <div class="infosec" >
      <h1 v-for="cat in catsArray" v-bind:key="cat.catId">{{ cat.name }}</h1>
    <div class="userDetail">
      <div class="userbio" v-for="cat in catsArray" v-bind:key="cat.catId">
        <img class="detailImage" v-bind:src="getImageURL(cat.imageName)" />
        <div class="desc">
          <div><strong>Breed:</strong> {{ cat.breed }}</div>
          <div><strong>Color:</strong> {{ cat.color }}</div>
        </div>
        <div class="occu"><strong>Occupation: </strong>{{ cat.occupation }}</div>
      </div>

      <div class="lives" v-for="cat in catsArray" v-bind:key="cat.catId">
        <img class="tomb" src="../Assets/tombstone.png" style="width:75%;"/>
        <div class="dLives">
          <h2 class="hLR">Lives Remaining</h2>
          <h1 class="dLL">{{ cat.lives }}</h1>
        </div>
      </div>

      <div class="rightside">
        <div class="rating">
          <h3 class="rat">RATing</h3>
          <div class="mice">
            <img class="mice1" src="../Assets/mice-icon-10.jpg" />
            <img class="mice2" src="../Assets/mice-icon-10.jpg" />
            <img class="mice3" src="../Assets/mice-icon-10.jpg" />
            <img class="mice4" src="../Assets/mice-icon-10.jpg" />
            <img class="mice5" src="../Assets/mice-icon-10.jpg" />
          </div>
        </div>

        <div class="placeFrequented" v-for="cat in catsArray" v-bind:key="cat.catId">
          <h3>Last Seen</h3>
          <p>{{ cat.address }}</p>
        </div>

        <div class="summaryDetail" v-for="cat in catsArray" v-bind:key="cat.catId">
          <h3>More About Me</h3>
          <p>{{ cat.summary }}</p>
        </div>
    </div>  
    </div>
    <div class="alert alert-danger" role="alert" v-if="registrationErrors">{{ registrationErrorMsg }}</div>
    <div class="deleteCats" v-for="cat in catsArray" v-bind:key="cat.catId" >   
    <button type="submit" v-on:click="deleteCat" class="deleteButton" value="Delete Profile">Delete This Profile</button>
    </div>
    
  </div>
</template>

<script>

import catService from "@/services/CatService.js";

export default {
  name: "user-details",
  components: {
    
  },
  props: {
    catId: Number,

  },

  data() {
    return {
      catsArray: [],
      registrationErrors: false,
      registrationErrorMsg: 'There were problems deleting this user.',
    };
    
  },

  methods: {
    viewCatDetails() {
      this.$router.push("/catdetails");
    },
    getImageURL(pic) {
      return require("../Assets/CatUsers/" + pic);
    },

    deleteCat() {
      const catId = this.$store.state.catId;

      catService
        .deleteCat(catId)
        .then((response) => {
          console.log(response.status);
          if (response.status == "204") {
            this.registrationErrors = true;
            this.$router.push("/");
          }
        })
        .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
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
};



</script>

<style scoped>

button[type="submit"] {
  background-color: #d6dae6;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 7.313%;
  height: 2%;
  position:absolute;
  top: 2em;
  right: 5em;
}
button[type="submit"]:hover {
  background-color: #ff0000;
  color: #163DA1;
}
.desc {
  display:flex;
  flex-direction: row;
  justify-content: space-between;
  margin-left: 20px;
  margin-right: 20px;
}

.rat {
  margin-bottom: 20px;
}

.mice {
  display:flex;
  flex-direction: row;
  justify-content: space-between;
  margin: auto;
}

.mice1, .mice2, .mice3, .mice4, .mice5 {
  display: block;
  width: 20% !important;
  height: 20%;
  margin-bottom: 15px;
}

.detailImage {
  display: block;
  width: 250px !important;
  height: 250px;
  margin-bottom: 15px;
  border-radius: 20px;
  margin-left: auto;
  margin-right: auto;
}
.userbio {
  display:flex;
  flex-direction: column;
  justify-content: space-between;
  width: 33.33%;
  border-style: outset;
  margin-left: 30px;

  justify-content: flex-start;
  text-align: center;
}
.lives {
  display: flex;
  flex-direction: row;
  justify-content: center;
  text-align: center;
  width:33.33%;
  position: relative;
  margin-left: 25px;
}

.dLives {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.hLR, .dLL{
  margin-bottom: 20px;
  margin-top: 20px;
}

.occu {
  margin-top: 10px;
  margin-bottom: 20px;
}

.rightside {
  display:flex;
  flex-direction: column;
  text-align: center;
  justify-content: space-between;
  align-self: center;
  width:33.33%;
  margin-right: 30px;
  margin-left: 30px;
}

.placeFrequented {
  display:flex;
  flex-direction: column;
  text-align: center;
  margin-bottom: 20px;
  border-style: outset;
}

.summaryDetail {
  display:flex;
  flex-direction: column;
  text-align: center;
  border-style: outset;
}

.rating {
  display:flex;
  flex-direction: column;
  text-align: center;
  margin-bottom: 20px;
  border-style: outset;
}

.userDetail {
  display:flex;
  flex-direction: row;
  align-items: center;
}
.infosec {
  display:flex;
  flex-direction: column;
  text-align: center;
}
</style>