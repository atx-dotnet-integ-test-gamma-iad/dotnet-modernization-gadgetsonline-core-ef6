# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution
Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

### 3. Run Unit Tests
If the solution contains any test projects, execute them to verify existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

### 4. Run the Application Locally
Start the application locally and manually verify core functionality, such as page rendering, routing, and data access:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

### 5. Verify Database Connectivity
If the project uses Entity Framework or another data access layer, confirm that connection strings in `appsettings.json` are correctly configured for your target environment and that any required database migrations are applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 6. Review Static Files and Bundling
Cross-platform .NET handles static files differently than legacy ASP.NET. Confirm that:
- Static files such as CSS, JavaScript, and images are served correctly.
- Any bundling or minification previously handled by `BundleConfig.cs` or `System.Web.Optimization` has been replaced with a compatible alternative such as LibMan or a front-end build tool.

### 7. Review Authentication and Session Configuration
If the application uses authentication or session state, verify that the middleware is correctly configured in `Program.cs` or `Startup.cs`, as these mechanisms differ significantly from the legacy `System.Web` equivalents.

### 8. Check for Runtime Warnings
Even without build errors, runtime warnings may surface. Run the application and review the console output for any warnings related to deprecated APIs or misconfigured middleware.

## Deployment

### 1. Publish the Application
Once validation is complete, publish the application to a folder for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output
Inspect the `./publish` directory to confirm all expected files are present, including the compiled assembly, `appsettings.json`, and static assets.

### 3. Configure the Target Environment
Ensure the target server or hosting environment has the correct .NET runtime installed. You can check the required runtime version in the `GadgetsOnline.csproj` file under the `<TargetFramework>` property.

### 4. Deploy to the Target Server
Copy the published output to your target server and configure the web server (such as IIS or Nginx) to point to the published directory, ensuring the hosting model (in-process or out-of-process) is set appropriately in `web.config` if using IIS.