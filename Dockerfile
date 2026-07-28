FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json .
RUN npm install

COPY . .
RUN npm run build
EXPOSE  5174

CMD [ "serve", "-s", "dist" ]



FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 5174
CMD ["nginx", "-g", "daemon off;"]

