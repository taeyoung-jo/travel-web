package com.travelers.travelweb.global.swagger;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.integration.GenericOpenApiContextBuilder;
import io.swagger.v3.oas.integration.SwaggerConfiguration;
import io.swagger.v3.oas.integration.api.OpenApiContext;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.Paths;
import io.swagger.v3.oas.models.info.Info;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;

public class OpenApiServlet extends HttpServlet {

    private transient OpenAPI openAPI;

    @Override
    public void init() throws ServletException {
        try {
            OpenAPI oas = new OpenAPI()
                    .info(new Info().title("여행가자 API")
                            .version("1.0.0")
                            .description("여행가자 서비스의 API를 소개합니다."))
                    .paths(new Paths());

            SwaggerConfiguration config = new SwaggerConfiguration()
                    .openAPI(oas)
                    .resourcePackages(Collections.singleton("com.travelers.travelweb.global"));

            OpenApiContext ctx = new GenericOpenApiContextBuilder<>()
                    .openApiConfiguration(config)
                    .buildContext(true);

            this.openAPI = ctx.read();
        } catch (Exception e) {
            throw new ServletException("OpenAPI init failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=utf-8");
        new ObjectMapper().writeValue(resp.getWriter(), openAPI);
    }
}
