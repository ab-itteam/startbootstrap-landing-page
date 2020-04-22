
FROM node:12.2.0-alpine as gulp-build
WORKDIR /app
COPY . ./
RUN npm install
RUN node_modules/.bin/gulp

# Stage 2 - the production environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=gulp-build /app /usr/share/nginx/html
EXPOSE 2002
CMD ["nginx", "-g", "daemon off;"]