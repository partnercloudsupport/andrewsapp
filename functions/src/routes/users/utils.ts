"use strict";
import axios from 'axios'
const localserver = axios.create({
  baseURL: "https://api.ashdevtools.com/andrewsgrowth-app/us-central1",
  timeout: 500
});
export function sendLog(context: any, data: any) {
    localserver.post('/logs',{context, data})
}
export function checkDistance(device: any) {
  function distance(lat1: number, lon1: number, lat2: number, lon2: number, unit: string) {
      if ((lat1 === lat2) && (lon1 === lon2)) {
          return 0;
      }
      else {
          const radlat1 = Math.PI * lat1 / 180;
          const radlat2 = Math.PI * lat2 / 180;
          const theta = lon1 - lon2;
          const radtheta = Math.PI * theta / 180;
          let dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
          if (dist > 1) {
              dist = 1;
          }
          dist = Math.acos(dist);
          dist = dist * 180 / Math.PI;
          dist = dist * 60 * 1.1515;
          if (unit === "K") { dist = dist * 1.609344 }
          if (unit === "N") { dist = dist * 0.8684 }
          return dist;
      }
  }
  const d = distance(device.position.lat, device.position.lng, 35.0, -95.4, 'M');
  if (d > 20) {
      return false
  }
  return true

}