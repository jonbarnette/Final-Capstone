<template>
  <div>

    <div class="livesRemaining">
      <h3>Remaining Lives</h3>
      <p>{{details.lives}}</p>
    </div>

    <div>
      <img class="image" v-bind:src="getImageURL(details.imageName)" />
    </div>

    <div id="userBio">
      <strong>Name: </strong>
      <p>{{details.name}}</p>
      <strong>Occupation: </strong>
      <p>{{details.address}}</p>
      <strong>Breed: </strong>
      <p>{{details.breed}}</p>
      <strong>Color: </strong>
      <p>{{details.color}}</p>
    </div>

    <div class="placeFrequented">
      <h3>List Of Places Frequented</h3>
      <p>{{details.address}}</p>
    </div>

    <div class="summaryDetail">
      <h3>Cat Summary</h3>
      <p>{{details.summary}}</p>
    </div>

    <div>
      <router-link :to="{ name: 'user-list' }">Return to List</router-link>
    </div>
    
  </div>
</template>

<script>
import catService from "@/services/CatService.js";

export default {
  name: "user-details",

  data() {
    return {
      details: {
        cat_id: null,
        name: "",
        imageName: "",
        lives: "",
        breed: "",
        color: "",
        occupation: "",
        tagline: "",
        address: "",
        summary: "",
      }
    };
  },
  created() {
      catService.getCatDetails(this.$route.params.cat_id).then((response) => {
        this.details = response.data;
      });
    },
};
</script>



<style>
* {
  background-color: #16ffbd;
  color: #c34271;
}

.image {
  display: block;
  width: 100%;
  height: auto;
}

/* .overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: #008CBA;
} */

/* .container:hover .overlay {
  opacity: 1;
} */

/* .divTableCell {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
} */

#main-div {
  margin: 30px;
}
#searchHomes {
  margin: 30px;
}

input[type="text"] {
  margin: 30px;
  width: 10%;
  padding: 12px 14px;
  border: 2px solid green;
  border-radius: 6px;
}

div.minimalistBlack {
  margin: auto;
  border: 2px solid #06b712;
  width: 80%;
  text-align: left;
  border-collapse: collapse;
}
.divTable.minimalistBlack .divTableCell,
.divTable.minimalistBlack .divTableHead {
  border: 1px solid #000000;
  padding: 5px 4px;
}
.divTable.minimalistBlack .divTableBody .divTableCell {
  font-size: 30px;
  vertical-align: middle;
  text-align: center;
}
.divTable.minimalistBlack .divTableHeading {
  background: #1dff2c;
  background: -moz-linear-gradient(top, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  background: -webkit-linear-gradient(
    top,
    #55ff61 0%,
    #33ff41 66%,
    #1dff2c 100%
  );
  background: linear-gradient(to bottom, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  border-bottom: 3px solid #0f9a39;
}
.divTable.minimalistBlack .divTableHeading .divTableHead {
  font-size: 30px;
  font-weight: bold;
  color: #109902;
  text-align: center;
}
.minimalistBlack .tableFootStyle {
  font-size: 14px;
}
/* DivTable.com */
.divTable {
  display: table;
  table-layout: fixed;
}
.divTableRow {
  display: table-row;
}
.divTableHeading {
  display: table-header-group;
}
.divTableCell,
.divTableHead {
  display: table-cell;
}
.divTableHeading {
  display: table-header-group;
}
.divTableFoot {
  display: table-footer-group;
}
.divTableBody {
  display: table-row-group;
}
</style>