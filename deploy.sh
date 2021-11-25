export DOCKER_BUILDKIT=1 
docker build --progress=plain \
                                --cache-from $REPO/$PROJECT_REPONAME:builder \
                                -f ci.dockerfile \
                                --target builder \
                                -t $REPO/$PROJECT_REPONAME:builder \
                                --build-arg BUILDKIT_INLINE_CACHE=1 .

docker build --progress=plain \
                         --cache-from $REPO/$PROJECT_REPONAME:builder \
                         --cache-from $REPO/$PROJECT_REPONAME:$LATEST_TAG \
                         -f ci.dockerfile \
                         --target final \
                         -t $REPO/$PROJECT_REPONAME:$IMAGE_TAG \
                         --build-arg BUILDKIT_INLINE_CACHE=1 .

docker push $REPO/$PROJECT_REPONAME:builder
docker push $REPO/$PROJECT_REPONAME:$LATEST_TAG