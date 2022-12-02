FROM node:14-alpine as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM nginx:alpine
COPY --from=build /app/dist/proyecto-base /usr/share/nginx/html

RUN rm -rf /etc/nginx/nginx.conf


COPY ./nginx.conf /etc/nginx/nginx.conf

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
