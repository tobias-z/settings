local builder = Snip.create_snippet_builder("yaml")

builder.vscode_snip(
  "kdeployment",
  [[
kind: Deployment
apiVersion: apps/v1
metadata:
  name: ${1:myapp}
spec:
  selector:
    matchLabels:
      app: ${1:myapp}
  template:
    metadata:
      labels:
        app: ${1:myapp}
    spec:
      containers:
        - name: ${1:myapp}
          image: ${2:<Image>}
          resources:
            limits:
              memory: 128Mi
              cpu: 500m
          ports:
            - containerPort: ${3:8080}
]]
)

builder.vscode_snip(
  "kservice",
  [[
kind: Service
apiVersion: v1
metadata:
  name: ${1:myapp}
spec:
  selector:
    app: ${1:myapp}
  ports:
    - port: ${2:<Port>}
      targetPort: ${3:<Target Port>}
]]
)

builder.build()
