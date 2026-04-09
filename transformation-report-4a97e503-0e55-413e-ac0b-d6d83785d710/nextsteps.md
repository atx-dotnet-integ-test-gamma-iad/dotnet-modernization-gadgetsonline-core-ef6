# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a checkout if applicable.

### 5. Run Existing Tests

If the solution contains a test project, execute the tests to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by the migration or were pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references — these are not available in modern .NET. Ensure any dependencies on `HttpContext`, `HttpRequest`, or similar types are handled through ASP.NET Core equivalents.
- `ConfigurationManager` — replace with `Microsoft.Extensions.Configuration`.
- `App.config` or `Web.config` — migrate settings to `appsettings.json`.
- Windows-specific APIs such as the registry or certain `System.Drawing` methods.

### 7. Verify Database Connectivity

If the project uses a database, confirm the connection strings in `appsettings.json` are correct and that the application can connect successfully at runtime. If Entity Framework is in use, run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Review Static Files and Middleware Configuration

For web projects, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Ensure calls to `app.UseStaticFiles()`, `app.UseRouting()`, and `app.UseAuthorization()` are present and in the correct order.

### 9. Validate NuGet Package Compatibility

Check that all NuGet packages referenced in the project support the target framework. Packages that were built exclusively for .NET Framework may not function correctly. Use the following command to inspect package details:

```bash
dotnet list package --outdated
```

Replace any incompatible packages with their .NET-compatible equivalents.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify all expected files, including views, static assets, and configuration files, are present before deploying to the target environment.