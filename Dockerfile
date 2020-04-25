FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx

# In most environments the EXPOSE instruction is really supposed to meant only for developers
# to read and understand that this container needs to get a port mapped to port 80
# In our local machine this instruction does absolutely nothing automatically
# But on other hand elasticbeanstalk is little bit different
# elasticbeanstalk is going to map this container directly into the given port automatically
EXPOSE 80

# Copy something from builder which is /app/build folder and paste it to /use/share/nginx/html dir which is root nginx server folder
COPY --from=builder /app/build /usr/share/nginx/html
