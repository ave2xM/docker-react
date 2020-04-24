FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx

# Copy something from builder which is /app/build folder and paste it to /use/share/nginx/html dir which is root nginx server folder
COPY --from=builder /app/build /usr/share/nginx/html
