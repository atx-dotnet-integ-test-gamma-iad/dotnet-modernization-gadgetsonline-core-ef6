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

If the project is a web application, ensure it targets `net8.0` or another actively supported .NET version rather than a legacy `net4x` framework.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior matches the legacy version.

### 5. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references — these are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` — ensure these are sourced from `Microsoft.AspNetCore.Http`.
- `ConfigurationManager` — replace with `Microsoft.Extensions.Configuration`.
- `System.Drawing` — replace with a cross-platform alternative such as `SkiaSharp` or `ImageSharp` if used.

### 6. Run Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences in the new framework or pre-existing issues.

### 7. Check Runtime Configuration

Review `appsettings.json` (or `appsettings.Development.json`) to ensure all configuration values previously held in `Web.config` or `App.config` have been correctly migrated. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication configuration

### 8. Validate Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Ensure the following are present where applicable:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

### 9. Review Publish Output

Perform a publish dry run to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish-output
```

Inspect the `./publish-output` directory to verify all expected files, assets, and dependencies are present.

### 10. Deploy to Target Environment

Once all of the above steps have been validated, deploy the published output to the target environment by copying the contents of the publish directory to the server and configuring the host (IIS, Kestrel, or another reverse proxy) to serve the application.

For IIS hosting, ensure the **ASP.NET Core Hosting Bundle** is installed on the server and that the application pool is set to **No Managed Code**.